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
    sha256 cellar: :any,                 arm64_sequoia: "2ee195135ef8b82392fd1e0f6411563272d0d6a5aef64f7d4c21fbf3c8c2fce4"
    sha256 cellar: :any,                 arm64_sonoma:  "6e7d4dd20e09b4abe16f1557e0a5e094a3b43a469a0ac1a70c743ab67ed62115"
    sha256 cellar: :any,                 arm64_ventura: "e777eaa45424e2af91d7bb1506cf361179fbb50f583fb37034e6dba0ec1cf827"
    sha256 cellar: :any,                 ventura:       "24269b56d0aee5a0d04c2aaeb83104d54cd5e78bb257729718544b0fa2c9f532"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8495e25c34ae29ad617cc87e90b887ca108274659b4e72b44c67eb0944af82a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90eac502bc2fb64fa5ca8f2fbb2b0854cd8dfac9aa5419fb15488413538f6956"
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
