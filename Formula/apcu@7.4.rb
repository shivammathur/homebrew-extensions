# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "996f9d5475bdcf918fc3948603dfcc0b09653545a800d30eb3a396914801e2e3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "845884d0bf8d58f5a45cbac883e718c66e3f548910bdd32ffd98bc8799e6516a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae2beb2c7641736afcf863f3b4cc12c4368f2509579384f8b48cca789b4b71e4"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff0fd4647b4da81fea0e34f9b86f6c153bdffa530b272fc6676b49fbcaecb41a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bc0cf92f977e1944b9baf3f441dda8b7aefa5ede7e81aa3d3f55031ec9536b37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4e27275761b65fd04267e67e32ea7fa0b7af89929618847166c741926d74fd3"
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
