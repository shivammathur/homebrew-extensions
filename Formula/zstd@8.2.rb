# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a4080ca4aea46bcbc06c176ec3dd678505a4008abc22d5b3e2cce037e2480d86"
    sha256 cellar: :any,                 arm64_sonoma:  "14351664afffef372d508e417611800b3db4374aa1b40a93e84005a330f20e70"
    sha256 cellar: :any,                 arm64_ventura: "ee1b78dde06a6c988a650ce4df264f747f9cded0fb5eea04c3b982b1ee074f50"
    sha256 cellar: :any,                 ventura:       "a8eee092ff23e4a3263bf52c2ea24999ee2cd4b692a1cd446bcb6a7da53c53e2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa7fe95adbd1e54727ab924326da36a59e6ef73f06c52c8cb5f034619b70b017"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05c326c9a1c6ffc27709431f074cec0aae3cd00cac7581d3110b330f4ea332b9"
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
