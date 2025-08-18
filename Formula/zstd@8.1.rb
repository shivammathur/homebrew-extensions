# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "b91eb2e69be626eea08f75e7d9aa7695689739263f351e097023bcc0b9bbb548"
    sha256 cellar: :any,                 arm64_sonoma:  "57181e48171cc188bf1baac3fef55c136d86384c051e14cfa56b4951db09bdb9"
    sha256 cellar: :any,                 arm64_ventura: "4c4af457cdd839d6e5841e4a7e083d5a0a8b0600acc98894afda7f8680af8445"
    sha256 cellar: :any,                 ventura:       "f7e2e84d99a19d1fa00e4db862f2daa7c35075735aab903477354c46a534643c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "677447080244e195424ed800e78d5fddd63b0262640c892917544f39e6a29d0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e1b93d3996444e367afc70389cebb6351ae0ddaf123ec05c14173376f3e4f99"
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
