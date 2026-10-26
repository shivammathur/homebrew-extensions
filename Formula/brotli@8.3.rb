# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1c28187b0e74247cb0b47d898b34a7e54f6a58e4154f9a3fef505e7fba4fc251"
    sha256 cellar: :any, arm64_tahoe:       "9dfea5e763cbe669d7d171260f434326d1fa9f9a8e9d5fd9f7cb9fb04d6b0738"
    sha256 cellar: :any, arm64_sequoia:     "57a8927a2bca3052fe20f0349abbed7642354c1a9bf71adbf410a508d5a8d22f"
    sha256 cellar: :any, arm64_linux:       "2fdd1792356b01196f8dfabbe8409296290d9b722bb3edcf0a272c2f17d01337"
    sha256 cellar: :any, x86_64_linux:      "a00f69f7b8c244d4b9192e5738843c34e50985c4db7feaa88df92a77b1f4217e"
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
