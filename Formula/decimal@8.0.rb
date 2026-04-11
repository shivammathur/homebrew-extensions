# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT80 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.3.tgz"
  sha256 "168bdcc445e1557b889df5e46313825f2abc77c5d7cfb7a4215063d2f7ca4a97"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a1ca36d1f73bd9d775d8244412c8a0b2817d901cae07c3ae9bb05f6fb406b460"
    sha256 cellar: :any,                 arm64_sequoia: "236ee05cc3f3ae1aaca118e79c4be01ecdb5426a521a582b8d04b5e787db69ff"
    sha256 cellar: :any,                 arm64_sonoma:  "d63f30e8b443bca8f53d90f3ced44bb329aa33debe3bba3eee4052dc3952f2f3"
    sha256 cellar: :any,                 sonoma:        "6cc3637dc0528eb28f5755025a47390958c93b2e365c2568c6205e129fdb4da8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "035c6302cb505164456526eb6355582819ac268668cf0606d6c0f65780dcbe46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "20114b9e2b8d682ec0f75d6ddd5f46341be96cfc099f919be8390c63776e8c51"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
