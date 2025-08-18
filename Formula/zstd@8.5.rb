# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "fa72e072d8b92fce60b4bb17da80b3cd118e21a0e1e8e2a111263ef444b18765"
    sha256 cellar: :any,                 arm64_sonoma:  "583e6ce916d1691f95e1c4e49fa90148dbd2bab8b2539a7c9444aceb9a50ba49"
    sha256 cellar: :any,                 arm64_ventura: "11d5625b3beb2edf8600ee6718b5c68372238a30efe205a8bbb2e1a7befe9a27"
    sha256 cellar: :any,                 ventura:       "724aa9f40c0a3252ecbd5d3647e42a2b52b822ed948906b4242a80963803d4ff"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "85472b4bd24d83ba1f8eba612e80c030f2ee069419ef0aac16abb3bb31659b44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9509714b63cde9f82d1f4433adf8c808a498295a69dd7d8c1cd64d10c78db7d7"
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
