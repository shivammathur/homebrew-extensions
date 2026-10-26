# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "c048e7e7dac317c3cc2f65ec5902981f302c4cc0a7d90d142c2e8dd6199b48c3"
    sha256 cellar: :any, arm64_tahoe:       "eef750586b94afb2a4e2bd3abeae5c7e4ca1c061103733b5a871e8ca51794fb5"
    sha256 cellar: :any, arm64_sequoia:     "cd7d5648ddd0835be09a0774c1d623f7bf0930c65f1b3e5d85fb530f0ef9b043"
    sha256 cellar: :any, arm64_linux:       "1a11f0b69b6973c5ef92170fdc81c491183a40cc531e0d88931bd5c0736198e1"
    sha256 cellar: :any, x86_64_linux:      "be4b66a829f47481a891ceb6063e2f98886d39533a7602a5c5fc0f3f3b786354"
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
