# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa4d1d6757288dcd90df6229dff4db1b03a2d2b73e5243db49007b7a4877bc07"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4a25184b2daa31e56400b021cd729755b3735237d24b702c1559bbdb7cad5df8"
    sha256 cellar: :any_skip_relocation, ventura:        "ebfd97998f5834be7ea74017f30fa85c51d87e676fc0b26559636022dcd481db"
    sha256 cellar: :any_skip_relocation, monterey:       "06a8b2076a5f242ae4e487189cfe3bc7c1e44f3db389e06f86baf26442c6443f"
    sha256 cellar: :any_skip_relocation, big_sur:        "59ee83ae1e56c2a38fd330fa95594b521edcd10e9ccbdfc6f144ebd6346aee29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b21db5e47c67d9755ab34576aa033e60bf20a79423a9dd8483bebed050f74a6"
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
