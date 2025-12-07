# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1cfd874eeffc70dba01dc56685914e97662858ea190fa35d9009ea71f507e9bc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a69093ed59908268df62d722e9fec0a5772ea4278dd11420c046212670680fb2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d3db3acda0cd834f5cae5f2c838ce48d69db2ab9e07a8681d1797c60b70bd1fd"
    sha256 cellar: :any_skip_relocation, sonoma:        "5159c8ee1ab4658ee333aeff03a6981a70be5bb044aafeb34bae6c45b63b6694"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0b161cbb9a2850bc9cfc4ccf6c1d9f636c2177131ed3ac144d0ef05d6f35b0fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76814a061388f5d2d35f750613d15013ba11e091a45811b6efd4afe15aeb376d"
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
