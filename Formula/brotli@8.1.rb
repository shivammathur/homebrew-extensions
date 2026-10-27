# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT81 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "76c09881ae47ddccabd94d66e779831481dbd34b53f1bba444e5a080013b3e1f"
    sha256 cellar: :any, arm64_tahoe:       "f9595f63d09f1d5fbd710982d8b2fde298832784551203195d6a8914754a6706"
    sha256 cellar: :any, arm64_sequoia:     "4f780b0f09299d8362dc9d5700a8f92a2446573debfd590aa0d6eab326ea0df7"
    sha256 cellar: :any, arm64_linux:       "615334fe79108aa290b581b05ec94ba121b055d7803b36ccab9082b406464a75"
    sha256 cellar: :any, x86_64_linux:      "188f9dda2cdfaeaa51667f262c3742c8c8a454f52951a5b9e84b0feea73881bb"
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
