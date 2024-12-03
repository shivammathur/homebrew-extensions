# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4ae7ac9c97783905b7a67b7cef38754d5d0dee086d94aabb8c6729bc969e7b73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2e2ff144ac711f86fa29b5b8e8daff06f19af9d773e97cec82cad290840ad956"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e4516dd1dc832e880c630301787f97e766723b296b7d48f63146c7b6d44ffc53"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2eb41ba9bec513fbdcb0d1c6dc0cbdf5edb52d5a8e92618fdf1bdf0658274af6"
    sha256 cellar: :any_skip_relocation, ventura:        "383eed66cda79c7f59624f14628303ee7eb3d939514689e3f762ae0b0bf2011e"
    sha256 cellar: :any_skip_relocation, monterey:       "3b0fd4937dc851a2e00c669d30abbd5c107819985d011862e2137ecaeccd6d34"
    sha256 cellar: :any_skip_relocation, big_sur:        "6aae8d986bf0814ab8ba0e0012b3869cca4c038b6ca61979d532e93c20c5d6eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cc79384ea7154e6366d3a7d3f2dfea7cc8e9c86cc448c1b8a962afeb67f903de"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
