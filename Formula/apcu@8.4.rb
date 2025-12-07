# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3c0e74ce4d7258b66718526e483c98f4f8ba9f0fe62d269b1dbfd12818a36888"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e0e2649e7a3bc134787f2052ca77144c226259523c8e4e8e2c536ca8eb09ca04"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "76e87d151db8485846b44638dbd7e04a1ca168d018afd738c2d4e0e868dd3d87"
    sha256 cellar: :any_skip_relocation, sonoma:        "88fb7bf88b105d0f7a9ef6ff6b040db04ad5612a7789a6726a6a4795d5031fb6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1fbc7792215a65f6f5d6d312e1a95db37fc3f984ae911f018f822a275a5b0a09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1904b06eb95e34999fb044683af002b6bcc010ca9f7c938b19d4f6afd35ef85c"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
