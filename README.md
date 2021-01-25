![Screenshot](schema.png)
### <b> About project </b>
This configuration for opensips was customized, written and tested for opensips version 2 and had serious memory leak issues due to lua. The leak issue has been resolved in opensips version 3.
### <b> Configuration functions </b>
  The configuration serves three main functions of sbc:
  1) Protection of the network perimeter.
  The answer to the methods of the sip dialogue is possible only after preliminary authentication, for which the user_id of the packet is compared with the
  available data in the subscriber sbc table.
  To speed up packet processing, data on them is cached in the memcached container.
  The packet processing speed is handled by the pike module.
