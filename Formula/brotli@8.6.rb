# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "151831b675c5db34270c297d00a918788d5815e9778517496225b5466f523521"
    sha256 cellar: :any, arm64_tahoe:       "f0d59a3c66d6b09c9ca5522f1912910ab71d965618ed6dbb5eb77bd376d303d0"
    sha256 cellar: :any, arm64_sequoia:     "5b465ada525030f8577635e08dce26d189eaeee44d0d2a2fecddeb72f13ddd37"
    sha256 cellar: :any, arm64_linux:       "19f4287eed214289d21feccf91c47e19c62aedf825787f41508b205ddc5a9c38"
    sha256 cellar: :any, x86_64_linux:      "b016138b048c980e4eee0da838ab4222344a978f92837acce0d6cd72445cb008"
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
