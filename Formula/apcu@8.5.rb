# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6ac7b1947ab690816e844b7ec0efa5fb5653ecfdedc01f7a0a5dae27a9abac17"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "da8f1f7be7b62ebca0c749b5fcf070f6f116889c1e9c9f4095cedd295a6c96b0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "32b2fde1624e12adcb1ab1586356fa49e48fa70b4062deac8af4d927be14f4a8"
    sha256 cellar: :any_skip_relocation, ventura:       "26aebeee52d401b8be2de8187a338e09fe7099ac7db32938f59125d092bc55ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "650845239e9ccd64ac0ac1065c8f040c0be2629391e1ab58c6a9e91081d3ea38"
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
