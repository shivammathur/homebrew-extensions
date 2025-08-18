# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.1.tgz"
  sha256 "5dd4358a14fca60c41bd35bf9ec810b8ece07b67615dd1a756d976475bb04abe"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "91c3687b044aabc96657fc28213292c6274ddeee790991b4fef4e075b9065df9"
    sha256 cellar: :any,                 arm64_sonoma:  "88bc8a06440f23a84a3fc50d75c10326c2eb3d8d25ec869adedc82faf7f78471"
    sha256 cellar: :any,                 arm64_ventura: "0322e7b002058244ab6c21e3ec44ac3a758926f89f6b7600aab4d5e630bb0153"
    sha256 cellar: :any,                 ventura:       "f2f92558588a3012e1feec331ebf295c1c4027572027b4719c820908eae7f1bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5d4279bb266823e7aa85af252e950b0d9064827900dd652eb5615d3cf10b1f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd5df9afb23e7b2a05b1839625debb2e7a7fb83f4f982764b02f73e5114ec90c"
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
