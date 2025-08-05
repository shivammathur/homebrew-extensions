# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c0a08d87a88db0f7637b2e102327efec9f4546b8ad853847c0f22da4a979ad9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4238d5e208470557cf43cc1f3138543ef9d0f2f5d5d74aab733b14fd820943b5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "10dec470e7fc043833f4150af73fb4e254456ce1461098c75948a38fdf772ce6"
    sha256 cellar: :any_skip_relocation, ventura:       "f5cba0961885d4fa2ef9d167300e05c293753b878ce1dfccec4e1ff9379d590b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "52e1ca40078c49a1e7555d422a152a4af967332b8dc0a57d7066542fe606185b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8014aca891949b3e41a00794c257aad6787d3c2fb795e47c8b61fc784f3e95f3"
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
