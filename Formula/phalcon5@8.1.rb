# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2236918251e7d7ecf4c5079f34a26b72608d40130a3b3b2e15fb29920536930c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "16ff41d6fbe51fecccc1ea6545aba546f838b8305126c22ab9ba26cf3c944516"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6c1b11c84caf00c1deede43eaa16dbc624c920d02b98f170382558e11a2cf280"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "655c162a7a06409be81156fcc6ec5045d8aa00d037b793109e568ad63666d7cb"
    sha256 cellar: :any_skip_relocation, ventura:        "beb2a5925e9ad467a78872af969f59ca896c181bd8d62c32dcb7c858120a3208"
    sha256 cellar: :any_skip_relocation, monterey:       "f3835e7762da3996c8fdb48fdd8994d50ff5353c5e7dd6dec3b0213c180702f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18cc1349283e330923b40b2a55f0a73d6042ef7da1fb70560462a7aa417fcfaa"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
