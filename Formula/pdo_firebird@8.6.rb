# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f97ff597429a2fe633665a7e02d97c8077f9f90f.tar.gz?commit=f97ff597429a2fe633665a7e02d97c8077f9f90f"
  version "8.6.0"
  sha256 "489bfb07ba2fe745aa250edfeb7189a6da6d3c1bf0cdd626b38dde199c6452bf"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "426676d6b7695b36fc16ebf90baf0e7386513bae21e92d4c3fce5378f905d1fd"
    sha256 cellar: :any,                 arm64_sequoia: "f52089529bf18c01cf6c617043eeac3c9b15769b98ef306f08312bfb4849adbb"
    sha256 cellar: :any,                 arm64_sonoma:  "304bc1780ec405739f00623e9277bb8fbf8ae0c51e5572ea0c516e99372fda68"
    sha256 cellar: :any,                 sonoma:        "9be265d106a6c4355e251ee98d8a1306d32ae874367e767098eb0471209cc8fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c6d96d034afd72809da1a9e3794d05ec5c2774a790e08539eaf13e026a57222b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "263bfd24ff39b6af521a6b0b28eba3ba825b4ed0f3431d92694f708986316e26"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
