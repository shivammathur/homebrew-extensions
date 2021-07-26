# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.4.tar.gz"
  sha256 "30a70eca00d0acaf4979ee532143aebe11cb325a5356b086f357cc3f69fe5550"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a3a9097fd42db1b0c63a43c8ce6a578c076895bfdbbc0178b63c02a018501a30"
    sha256 cellar: :any_skip_relocation, big_sur:       "3f5129b6abdac5496a5ed89231f54da8dc37c138bea7884d95ca189dd1bf3d4e"
    sha256 cellar: :any_skip_relocation, catalina:      "c0abf8770246dea2ffc5c2325d6f0a6722b0885716387e9eb167a4de539c8b97"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
