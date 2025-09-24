# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "340454f2b78bdf78f59c26db0f2eed7f020041008559b64f129ada5b01f6fc36"
    sha256 cellar: :any,                 arm64_sequoia: "fc054d618fb5626af9c73b627187e718bed67faa8812fc77e8f8ecbaa25fa33a"
    sha256 cellar: :any,                 arm64_sonoma:  "0f802d7087da0a100c42f712a51837dd834913f58d1336f66f4700ba8fdbfa02"
    sha256 cellar: :any,                 sonoma:        "6dd282875ae4c93b13c5a96379afdf18c7097daba1af87d14ac2f2f29ec170b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "96fb098cdd60b3e5b0a8fb30ce0ed0c500447cbd6f36e7f930b3ad63dd11c99b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d0d2dd128fda4e07b3a1b02b49fcbf58035d4a69106e4fd7ccfe89bfcd64f199"
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
