# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "1c836e985dc597bdb61835c0ab3d3b66788aeceec52ba5953597c9d6a18b966f"
    sha256 cellar: :any,                 arm64_sonoma:  "906af2e3771e5d70bc4f876974887f9a27215182644d004b161fc50b55987051"
    sha256 cellar: :any,                 arm64_ventura: "902049b29a2031f6c59994bdee62585ee970ca7f332f547d3d6200b1ebdf53fd"
    sha256 cellar: :any,                 ventura:       "6f8e9b1430344bfe61bfe75dbeca784cfdbccf4d2288d888c93a0cde72bc51a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0751846d46259ae8710f0d02acda7c82a11cbe05d31cbf946da9c0ba815e837"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d81c121decc486b9a4e80711c484758eb7613fd061f72d5e9d362d8aa4ebb3cb"
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
