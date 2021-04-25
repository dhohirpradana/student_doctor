import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

Widget autocompleteTextField(controller, data) => Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
      child: AutoCompleteTextField(
        key: null,
        controller: controller,
        suggestions: data,
        clearOnSubmit: false,
        style: TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          labelText: "Dosen",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, //this has no effect
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemSubmitted: (item) {
          controller.text = item;
        },
        itemBuilder: (context, item) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(
                  item,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          );
        },
      ),
    );
