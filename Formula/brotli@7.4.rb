# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "878c224df42b86f0ec2112d46edc825191fb4480d35903d268946e1b915e823a"
    sha256 cellar: :any, arm64_tahoe:       "479a3c3833da2952783b542e4f4638235e4a413e11652289d7113c72232cff1f"
    sha256 cellar: :any, arm64_sequoia:     "8b4995748d7f7d31223d20233251ac6aadc29f39164f445fc544caac5a743358"
    sha256 cellar: :any, arm64_linux:       "75a969ad3a94709286bdfb7c249452fe22f07a07435b9417fd36c197d1c9d1ad"
    sha256 cellar: :any, x86_64_linux:      "3c1f95610a022297a9756e25b285bf7f4044e4b335e6a035259a39b3b031128e"
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
