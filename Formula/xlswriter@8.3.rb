# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e654e04bae4e53e5a14a9e1e9eefbcdcb8042a7887fd8850f826fa7d24926104"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c3f3502c273262f7b9344f7b18c1e77c0f7a1cab15e500acd6b5be192d08c983"
    sha256 cellar: :any_skip_relocation, monterey:       "8f22ab1529533aeda3a34344b8b368beb69b0f5ac9020ffb9ccd86860a204a43"
    sha256 cellar: :any_skip_relocation, big_sur:        "00396a7668cd9d16b78b33d7b7ac0b195a413f039329fd66b1b47251eee96692"
    sha256 cellar: :any_skip_relocation, catalina:       "8f7ab69c1d9cdd749aac7ae5a6a9520b34d945d2ba9f6b3bba46dd99bf92fad7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fc3d4a0251e076457c53a74e82895d2816b1f6759aebc163517df2b00b42278"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
