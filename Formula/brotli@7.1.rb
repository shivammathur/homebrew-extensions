# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "7a5fb2b2a7ebf28ff3ce41a281ef3713bf1249577886d6f2cbc24df9f12d9e9d"
    sha256 cellar: :any, arm64_sequoia: "cf2cfe677f5f427a59a376c1521a37efb38db17e6ae2452588ec100f3c9eeb7b"
    sha256 cellar: :any, arm64_sonoma:  "6a7d498fb97498256ae78af496cedbb2e6a382c76323ce7d6615275fd60e9f74"
    sha256 cellar: :any, sonoma:        "f9bf9db083be710cad31dbf59598da1f8b34af605e784b4cfddec3864bb6711b"
    sha256 cellar: :any, arm64_linux:   "2383ca6972fbad5bcbe368eef592a75e322c103f1023f8596ebefc04779be7ea"
    sha256 cellar: :any, x86_64_linux:  "d6cdf796782504c138da7c405889e11c97b4877d97ea5c066368b29667ce3a25"
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
