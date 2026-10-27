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
    sha256 cellar: :any, arm64_golden_gate: "bee6f784378a77c31d17c285888466e92c575d058a6337fc5f85eb1c71b75221"
    sha256 cellar: :any, arm64_tahoe:       "5069e9a85fa5f7cfffb090ed9bbc7fbdbc7e0f7dfe2ff51ac5e5a515039a7653"
    sha256 cellar: :any, arm64_sequoia:     "50f296741219626301bcc02701f92df104a8b6daebe6e06b64da6dc59b77098b"
    sha256 cellar: :any, arm64_linux:       "96c8952400c5917e0f0415d076bba7497eeeb3477d855924e1026f64bdb8af7f"
    sha256 cellar: :any, x86_64_linux:      "30528c39f2448f61e74140257e9fd108c0cc0b46bda8029e5f9b50c539605ef2"
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
