# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT87 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c5974622d224bfef8962f6d6b329cd794edf10d4cb113401478208bcb30214f7"
    sha256 cellar: :any, arm64_tahoe:       "f6bd47f37ee44884758eaf8ef6ac66aee87b56a899ce285f920322f7a47b50a9"
    sha256 cellar: :any, arm64_sequoia:     "74214dfd3228864070c91bc7a8fd962f3ea25958ada5c357f5351afe7714663e"
    sha256 cellar: :any, arm64_linux:       "620b2f9f0a0ca4a6133f88ba02cbd57969a7861a57ddaa7d8b1171ee900f3100"
    sha256 cellar: :any, x86_64_linux:      "f61d5c193ea4cf4c857d811422207bac5432715944119e109134fd8f9ac528e4"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
