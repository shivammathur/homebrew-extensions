# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  revision 1
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f0771b65a577a388be19e936bb2b4add4d72dd7077ce101b1b933cfccf959271"
    sha256 cellar: :any,                 arm64_sequoia: "3671ec3c88414b0efd3bf1e05cf3cf54df2e12a65c13ba186b49c1d74e5e1e1d"
    sha256 cellar: :any,                 arm64_sonoma:  "dc6b04f6b3db9ea9ee5742ad58725a639cf846ee8dd4cdcb2acba1ba3bf25d67"
    sha256 cellar: :any,                 sonoma:        "4d18c0a21e156ee208dd921c982680d539c85ce5c54014896db46beb50052842"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2edc55fc3517d58992226692dc6e189a0483e61adc47d1ac6d6ab01799c549f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0b27b05b89e39b749d83de8936b5d709649ad5da1841358bc4be1753834ed31"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
