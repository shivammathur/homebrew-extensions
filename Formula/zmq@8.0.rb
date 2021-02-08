# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT80 < AbstractPhp80Extension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://pecl.php.net/get/zmq-1.1.3.tgz?init=true"
  sha256 "c492375818bd51b355352798fb94f04d6828c6aeda41ba813849624af74144ce"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
  end

  depends_on "czmq"
  depends_on "zeromq"

  def install
    args = %W[
      --with-czmq=#{Formula["czmq"].opt_prefix}
      --with-zmq=#{Formula["zeromq"].opt_prefix}
    ]
    Dir.chdir "zmq-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
