# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "df7835c838eb65f88653312af51fe55c08a1e834335ef7c4c72b3bcf8b68defd"
    sha256 cellar: :any, arm64_sequoia: "65dc0c8e9f4cda4a9699332930f936074b1e21718130e2b845343dae2f40c148"
    sha256 cellar: :any, arm64_sonoma:  "e3df2e48d0345db028461038b6efb433dfe2d0b0390cb4fbdd91bec665a4d571"
    sha256 cellar: :any, sonoma:        "62bd09c4ad5bed7d99622f3135bd2a34103732c68e4a945217d2e3c3ded829b8"
    sha256 cellar: :any, arm64_linux:   "0936e841be533332f6fff75a7bc35f80ab2e8f1abb33485f2c366da9c592f816"
    sha256 cellar: :any, x86_64_linux:  "3b97d2f4224ef732cef780c7ea0e5c467e2289d15690b16e4d1478fd161df5e6"
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
