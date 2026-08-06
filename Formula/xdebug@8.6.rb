# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/9df1c18256940d273e537eae3d6115d6abf253d3.tar.gz"
  sha256 "99b7965bc1b9d1a0731476270acf11b894bdd751df53cb300b8c1cd133b9e92b"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256                               arm64_tahoe:   "e272e6c9fe79fa258b55c7d0741877b567da0a34db910abb66e972dfbeb8675e"
    sha256                               arm64_sequoia: "4862f0ff99d9f2b6012244eba3d6acf97ea9bd4b29143b19d9563349ee472553"
    sha256                               arm64_sonoma:  "e287cef4862feb62e20ad140490ed953bf93964b583b44498a62cc581f2f05c6"
    sha256 cellar: :any_skip_relocation, sonoma:        "5e3be765d5c452953bcc3cff4bfa09cef652dbb61641d1893898fdfb5a0df9c0"
    sha256                               arm64_linux:   "f46b5a2915fe68b0c817c006efd55ffb0830591bfe2d43871084a7ab22ae8c92"
    sha256                               x86_64_linux:  "271c9f854945c4bcbcf783e6c1c812f74142d1e77e490d63cf0b06dc4b463536"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
