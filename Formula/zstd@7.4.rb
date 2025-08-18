# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "bce3f7fbb1f6ee8280a95336b828c02ff9ff8e038050686dd3ba0b94fce967cf"
    sha256 cellar: :any,                 arm64_sonoma:  "96040814d05c3c760492c271c8ba2519c423203a177099fdb6c756a76dde73a0"
    sha256 cellar: :any,                 arm64_ventura: "c3917c55ee14fb6a6e94cb1eeba2d2ebc205d0d3a21c5b38012c63816908ed66"
    sha256 cellar: :any,                 ventura:       "f620835075cd0c4c8cc2b69ed5222ac9cfd4d15a95eec531b10b5687e1058511"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "245fb9a43c081ec43a8499c4e8ef5e5f15d09b8337bc461c9f1409b75cd4e6a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f415c297c1c419175afb1fa37d315c8e540c6b5462bae4ee635d3365c92dc40"
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
