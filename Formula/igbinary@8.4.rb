# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bebf3c2fc2361ae2770c91bc0e925f9bdf5b21c4a6b3ed4ed802e7b56ff1393a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "34fbb968e636dfa18bc4def7faf7117ff6d9e49f0eca8a1364307694c94a8d5a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cf9d39c06d6544643dd47453c5c82302b7f62a640d901f4293b8860987e04ce4"
    sha256 cellar: :any_skip_relocation, ventura:       "a614f7c25babb6667c2a7f2b8fbb7537626a36d86eb6171b02682daaaaf52755"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d048cc717798f4d0d6304a7b7b568fed27ef50197d5649c96f47da0a04b3bfba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26c47fb4af80908ed52b1fcb7548413fb362bec469a4e80b4092f55dc07d037b"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
