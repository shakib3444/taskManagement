import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade300,
          ),
          SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Md.hasan mia",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
              Text("hasan@gmail.com",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade200),)
            ],
          ),
          Spacer(),
          Icon(Icons.logout,color: Colors.white,),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}