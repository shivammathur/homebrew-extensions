# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f50501a23ef97712c7c8215b49444e641b74b457925806a79a326852fc507280"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05245c48adcf00031065e6e07d0f69c6bb422e2507e636e2efcfceafc5e2c429"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61fcfab8983d796d46a45ddba93f247e9eeca4e06a798537795bf25ea0ec6250"
    sha256 cellar: :any_skip_relocation, sonoma:        "dfcac7d9ef8ad70a2ccabad004097b09defc4173b09e2be77abb1af59768aaa7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "427eeab899cc3fb0c59d7579ccb9b5c3f2a751a385789f350efbb255f9b9a389"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f31b030843425fa66cd46346bc764d68bd59852d7fba0f5f33cd9d3eb511f75"
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
