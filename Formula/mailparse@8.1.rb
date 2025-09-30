# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4262e6bf01dd367fcfbcf8d17902ecf8304e7cb95d9ac0e078f9e02062530781"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "af30fd6d315e569649e2056e2c8ea7ecc8310579b515ecec7c438a7703b20f3d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8b7a07357a33c8c587795aebe63fdf2dc82f807c15d9eaa951af53020e6cd0c5"
    sha256 cellar: :any_skip_relocation, sonoma:        "b7bdbd163a0188f9fbfb6c73448bb7814157a5a60b76fc2478348cb8940ead1b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f838930effc8609725fb2fb54a5e45e8dbd4c412ac8e0f97513b908b54600218"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de738352dc871a2e4bfbc98ff79965ec3eda4f41de3c6701c088a19ccf76ba5d"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
