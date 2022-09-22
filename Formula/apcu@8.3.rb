# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.22.tgz"
  sha256 "010a0d8fd112e1ed7a52a356191da3696a6b76319423f7b0dfdeaeeafcb41a1e"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "16982e5a716cef36bb7a065adf03f5d219b8eeb82a2a76e2cd3d9531052f0746"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "73bae1f4767ea71a2e7309292f4885f802516c6b72636a67a479331f15b19be2"
    sha256 cellar: :any_skip_relocation, monterey:       "63366ecbbee91780b8c44145e7d241b2462fdc2c2f2ce9a5066654e48e567fa2"
    sha256 cellar: :any_skip_relocation, big_sur:        "67bab5fb1274b98061a7f391a0403e93195fc27f71460d351959bf48b460d80a"
    sha256 cellar: :any_skip_relocation, catalina:       "cbcff27def6b28b4768d0dd4b61fc25e8bc4ee6c37247c0984ed45ef766dead9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "25e9302c6bfde480b4b6d205d696deaf0b98260831b3778b48d43124a811713b"
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
