# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT80 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7c1b156571407202c52929582c7dae0a1728cde0652c211e7deeee3093576551"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c45e9fc79626f12223b1b61ab86a7fa77201bcad63b8b56bad1dbc6af88eced6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "39ece7033472a965eacd111d9a9ed8b06be69532568ce7af65488bd956297221"
    sha256 cellar: :any_skip_relocation, sonoma:        "333aa9098da7c1b262beb5c03bcf35aa7652a9074a3479f622d5c25a76373225"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6015e61f7874b83d426a0a40ac21cf61da68babcc0c56fae090002b1aa29e42a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3ab4bc18bf6fc8e161b76b39bdfb108070c03d210e8fe3a61c738b7244bcc17"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
