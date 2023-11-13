# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/ea6e15410d7cf41f8bc18bc779c1e266ed9ccdf3.tar.gz"
  sha256 "c5fc61571465d105b49de8b4814eeebbdf840266f7af4bd66fd9bd25b47920f5"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_sonoma:   "aede910a0f193d498e976aee2c504608d4887f47ece56bdb649d81329ca0d2df"
    sha256 arm64_ventura:  "ec84364855ff0e2ae3a98d040027390182b9f8374030f5a80e4617a417678773"
    sha256 arm64_monterey: "dce48c3a3a310c0fb882edd455f8cabe22f216666028b2b3cd9370ed35a6776a"
    sha256 ventura:        "c1eaf966b8e7978f8b91c4eda37c70163630b2727db852dec48abbb9b2046ec1"
    sha256 monterey:       "0ff99138ac912cc6702de8db65c532eb5f5b480da7effc6f3138cd7ac4a37570"
    sha256 x86_64_linux:   "519b872dd1610ff3f9c18d43ecac5678f82c7a252d6f28a51e49daad3f99cfd2"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
