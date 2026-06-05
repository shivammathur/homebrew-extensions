# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ac3e0fac555426798a800cc770b35ef238b9af70a2cdfc7b52926d66277a396b"
    sha256 cellar: :any, arm64_sequoia: "cca5763bba3f2b135fbb98ab83efe9668cf4119aec08a787a100a65dda2317a7"
    sha256 cellar: :any, arm64_sonoma:  "47201c2aba0af652e776125622ddc4d08ad8b6a521d633daf590f9ea069fae95"
    sha256 cellar: :any, sonoma:        "e4d2bb7c4fa007fb2b6abf83055675870edf2a724a13eebdb8ccb17e6494e164"
    sha256 cellar: :any, arm64_linux:   "3ff2030d23ca049dfd0c440f90c9f586d1b16f1d24422b976f7dddbff1146ccb"
    sha256 cellar: :any, x86_64_linux:  "8ad46eae6f1e606934ab018fb335c32a67d989675598bae800c05b0370dd0581"
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
