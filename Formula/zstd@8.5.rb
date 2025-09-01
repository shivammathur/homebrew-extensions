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
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7bf29555d624d54aaaf73dbabc79124788b1b64377330c287a7dd622263b1957"
    sha256 cellar: :any,                 arm64_sonoma:  "c93d5c05c469885b0b1198761411cb0f225152db9fcb4f0e91c76d8cdf3b6359"
    sha256 cellar: :any,                 arm64_ventura: "0cdb6708691d738e2f90493b95fca202b23f6dd2d9c16ce280a180a7b26dbdb7"
    sha256 cellar: :any,                 ventura:       "89b3e31b0c9d0a9c2ee60c955f34beafe75278461118ca8b6562c5615068d257"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d51524fc50ae2635e9878a287ca4d1c69fdb94a412d5452cf8229a16ccc0ef87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22a6b7e13b6e226cd3e0b29d8c25d179da4281b6a8651ca805c788f111c12e2a"
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
