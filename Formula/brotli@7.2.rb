# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "5e1ac3ddde3fa1b520a629f0c2ee8836fe6e8a6e113d89f20583a87da3d494bc"
    sha256 cellar: :any, arm64_sequoia: "0643520209db9f1a2348a5a8b602d54aee5bc0cfcf27be42f895b4cdf59dfcfa"
    sha256 cellar: :any, arm64_sonoma:  "440cdc947f8b8675cae1efdccf907afea97773de8c1430f1deab7739a3ef3aed"
    sha256 cellar: :any, sonoma:        "b474904f40df5072ba9b54c35656e5fcc9a67c56a511ebe5cb2fee745516b683"
    sha256 cellar: :any, arm64_linux:   "8738147f38e0229f64358a4093c531a66bf2c38acef0b01ab64c414db341563c"
    sha256 cellar: :any, x86_64_linux:  "331345bb227b5cf49ff8904a94ce255e69cd5ddd8641420e4c62f49282c665d8"
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
