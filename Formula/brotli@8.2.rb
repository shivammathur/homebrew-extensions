# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "9b526f1ddabedd59a6e9a2b2965520a21100fd9e8d82c28f8740bf65a8c2c0d7"
    sha256 cellar: :any, arm64_sequoia: "d966d71ba9f360d3af342b05385dc559e7eebca64abd3d2818272c4c32f39a76"
    sha256 cellar: :any, arm64_sonoma:  "9b78fe1ace6bdfa10aa0d422df48121366c68afe61dc1ce622125ef8147bdc4f"
    sha256 cellar: :any, sonoma:        "f5ca5b21d90d7d7237ec2f72f05d3070f41af27e078f201d9fd508a42986f549"
    sha256 cellar: :any, arm64_linux:   "679fd3554c1e5045340f5dd3fe1ac35c0bfc741a581dbd55c7383821fc6f2f2f"
    sha256 cellar: :any, x86_64_linux:  "019286a04d58688e29767d7a83f3661acb5b09918d24f0699672c9cc8c285424"
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
