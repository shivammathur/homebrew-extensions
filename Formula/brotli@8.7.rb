# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "5e7be1809f0cf1993d10c185956220726a303c4f0de8a9b07c014ef03941a7a1"
    sha256 cellar: :any, arm64_tahoe:       "bdb9e86daa28fb4ec87bf8f23215453ed82b603b7ae4ecf9d024469c6a9c9e85"
    sha256 cellar: :any, arm64_sequoia:     "bda7e39658e42809384cade8e7553e74edc18d497846deb36d758c6db182e36b"
    sha256 cellar: :any, arm64_linux:       "67579396274fbbcfe935ed491fdfe85cf8df711b717ec5708d7b5e8ae1cd0f5c"
    sha256 cellar: :any, x86_64_linux:      "9e5cbc3ade0552e7be646e9d665f648e44247adc0ac53dc993a34bc1e66e4d58"
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
