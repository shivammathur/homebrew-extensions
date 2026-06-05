# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "655463bd64d68797d3d4acf6709e3aa91a6222966a0287e210bbf6428a05ec38"
    sha256 cellar: :any, arm64_sequoia: "9e77932e32fb92b1a15f868497a051d3fa922e407c815bbe33ef46735f49c3e1"
    sha256 cellar: :any, arm64_sonoma:  "4e843350fa897d12235ed3613c7eeff0df23ee33758c87950ab86f70adb12c06"
    sha256 cellar: :any, sonoma:        "7a5f3a1a886a67a49d2551dfe7a5fea73fc8e7e92dc5806a3f648f8b6fb429a4"
    sha256 cellar: :any, arm64_linux:   "b1898026e93578641481317a14f540f6835663b39583cc559b3e60c94829bd0f"
    sha256 cellar: :any, x86_64_linux:  "e46dfc6b408dd38aabd7b3f7cd59e10c1f1d431b71b437b99a8184bec2925f5c"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
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
