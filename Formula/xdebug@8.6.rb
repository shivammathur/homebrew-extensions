# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8f05d5c11ff24a906b671f5427b3101afe80cc04.tar.gz"
  sha256 "f0d672291b5635aff2a7d99d160a7c418a9468c6c0e11540b6461ad48a45eab7"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256                               arm64_tahoe:   "f1f27d68da6c9ed970f641513d3d3a579fcf7b1737fcf62f3121771ff26dba55"
    sha256                               arm64_sequoia: "e6c47b43cf6219f25996ccc40a7500ef87216b5eb408b96ee2256355d5115291"
    sha256                               arm64_sonoma:  "203eb6ce3c6dc50d63e86a9c45fa02a8c17a710d65477981ea2f3385154bb51b"
    sha256 cellar: :any_skip_relocation, sonoma:        "ab67d84026f6c946381c5767768491ebe2d976c0159c265abfe3adcba567e6bd"
    sha256                               arm64_linux:   "0b02a5f33c0dd46d2ddf0390538a72d7112f6da520965142c3d8fe9360a8ac3d"
    sha256                               x86_64_linux:  "7f2cc477b95ab595bf68da1fea0cdeecc3b9e84d687066f6de5e78753194db86"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  patch do
    url "https://github.com/shivammathur/xdebug/commit/13264e7ca3608026f710fb83c5f2314bdcc610e6.patch?full_index=1"
    sha256 "2c0ed06d8adcbdd534132bf4a30a8497a236b576d3dff4c92f1375ec0436f98b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
