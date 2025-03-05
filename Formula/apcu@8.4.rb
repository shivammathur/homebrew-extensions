# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b2c846e4878aa57c3568ef8d92a3e5a1703d29bc3cacd41fb30e9a5a9375e53a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fb9a025819d589d2da45f3cf08c2ef68f5775a93e39bcb8658359aee19978095"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0b89c2f65fadb52d21efaef10fe74a0bb5f5f6e21aa80ce50ad343f328b964a"
    sha256 cellar: :any_skip_relocation, ventura:       "506da38d569e421cbc091179b75144bc28f41d1c930c5eaff9ad406d4ff6ac6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba26ffbd99a0c6b1487bc5b515146faa779e99bfc99fc3f3de1394f91b961323"
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
