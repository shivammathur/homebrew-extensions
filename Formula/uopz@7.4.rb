# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT74 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7245e0ea3fa8cc0c23a7c30a3c0f7d1e156c34a03c7abd893cfbe3e624a5324d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "534a654a61f21405073c2f16199bab2978073f3e90f96032f985a8eb018ba923"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "489f31deb473174ff7e99713be1e23d713f2d9d39470f8291c0645cb9586cc85"
    sha256 cellar: :any_skip_relocation, sonoma:        "1f28d9e757dacb83dcc4ada7c4be7b98f7d6c3d437bb7a3e2ce67a4b1bc356f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "63bacfddffb783ac858a37c6c4856cfe3a17b42f166b8c6b967c60294e2cd317"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c789ba1aecec7451a4393a9bb793d6badf023761d526c793c425d866df8619ca"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
