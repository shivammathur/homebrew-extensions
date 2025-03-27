# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/752814261df1eedea9502debb9bda25adf5be7f6.tar.gz"
  sha256 "c80f8a0c18cc88e197d88d81d8a4e11ce3f6fb56c0881785f327912b3e83a32f"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_sequoia: "b1868abb06cfe28a05259dd8666bbb89b7f5e71c54cba88a7343325fd9cad104"
    sha256 arm64_sonoma:  "09fea1e01383990dfed80bb1f46431271ec4a496f7906dc70d17bc4ffe746af0"
    sha256 arm64_ventura: "1be3db494ea2360aca66ada35f2f48e5b9fb3250d41cfec3f45054a5058ecf6e"
    sha256 ventura:       "dd9b4296b7b240514613607730a542bbb7d3cc77ff6894fca91576af3e117581"
    sha256 x86_64_linux:  "007d982ac62ca00893784793c253e5458d075c43c63b9aed98314d7cc3460ae5"
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
