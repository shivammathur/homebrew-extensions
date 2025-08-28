# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d15222e9b0f66681b54aef70fa2a78c6a79185ea0fdeded563de5fd154e394a3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f8f3b30e525bdac8d9d2be4644952b7f3d4a2a4141eefed48ce104bd7a65af41"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0dd9f58e14c7ac02b809c1e040b9f34fee86570622653f355fcd98f54c0126ff"
    sha256 cellar: :any_skip_relocation, ventura:       "71caa3c83bee473cce63cc6a428c21fccd605cd00e2a470aecf3b57cc8796102"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "116e5777d3145af9fe4c8fd7a4819149063bf24b9ad88fbb9aa7de1d078eafdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7166229c48f06a56f154a04d81a33a56147c28ac500b06bfdd018ea02746e19"
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
