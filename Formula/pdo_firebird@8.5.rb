# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.5.tar.xz"
  sha256 "95bec382f4bd00570a8ef52a58ec04d8d9b9a90494781f1c106d1b274a3902f2"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3d7f243a12ff097c70d03e1eec96ebd9ac7d0b5476b369649591820647f28a84"
    sha256 cellar: :any,                 arm64_sequoia: "22616b5bf487c0d8d77bed24ef04fa63ac16f8985fd51aac4568ad92551886cf"
    sha256 cellar: :any,                 arm64_sonoma:  "975b7f5ef9401730a369215607c255629d57f27fc2f474c8a0d672954c694f5e"
    sha256 cellar: :any,                 sonoma:        "3fe4acad9f8fef542870ae6fc29421731b60dd105cff1ff994815e24a9504b76"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6b01aa138f21207539ff28a2ec8192e560cd12e61699214d2995d269fbb3a719"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa6b9615e5b6209134470d5efb6daeb3a867dc0aa63a6c7a462ffef7187746f3"
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
