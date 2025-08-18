# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "93ae45086c05e37bd01f656c289e45b0535dab5b8ec78ae03a102e495f95fb68"
    sha256 cellar: :any,                 arm64_sonoma:  "fddc915fe4efd901db5be0c73ff25adadc9a4137d7cee18e5b503401df98d964"
    sha256 cellar: :any,                 arm64_ventura: "abe90455331d35a32573d3aa4a7b9bb0ab2049819cc5f38e7b95cffa09f67211"
    sha256 cellar: :any,                 ventura:       "dfb0c4d3f93b204933f4642c63e34f5636a78226171a41aa8e21db0c5b70001d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0b2e33881bdb1ac2727184ef8467a8b376ef571aedea401955d7cfd9e9359afd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b30a010889b40ce36055b3485e4b3bec595a69a4298329acb12840e7eab62d3"
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
