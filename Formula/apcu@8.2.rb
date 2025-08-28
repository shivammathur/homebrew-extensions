# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fd47c13110a2c595b0c45049354f357350424086c2efe0e77c6eda94756ac406"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d17a50a08c360f4ab2bb8bcc254e2324414603701b31e457ce45b46926c8a0be"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dca4e20e3dc1951102ae6e246cd017041ebc4fd90a69d7ae09adf73ef029338f"
    sha256 cellar: :any_skip_relocation, ventura:       "14535180b2c72a698124885eb2d1ac281a6755770eff40e2d1427c49c628b2ce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "33de9111cb3347cd30e5dc1d89b91505f5863206ba2a611e15b3b2576c6cdab0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da96732cd48642187a3a9d0367e4e0d12dccdcb44c226ad0f872b8242d1d9845"
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
